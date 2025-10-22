local jdtls = require("jdtls")

-- Set Java-specific indentation (4 spaces)
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

-- Paths
local mason_path = vim.fn.expand("$HOME/.local/share/nvim/mason")
local jdtls_bin = mason_path .. "/bin/jdtls"
local lombok_jar = mason_path .. "/packages/jdtls/lombok.jar"

-- Debug and test bundles
local bundles = {}
vim.list_extend(
	bundles,
	vim.split(
		vim.fn.glob(
			mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
			1
		),
		"\n"
	)
)
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "/packages/java-test/extension/server/*.jar", 1), "\n"))

-- Workspace path
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand("$HOME/.cache/jdtls/workspace/") .. project_name

local config = {
	cmd = {
		jdtls_bin,
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. lombok_jar,
		"-jar",
		vim.fn.glob(mason_path .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		mason_path .. "/packages/jdtls/config_linux",
		"-data",
		workspace_dir,
	},

	root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", ".project", "pom.xml", "build.gradle" }),

	settings = {
		java = {
			format = {
				settings = {
					insertSpaces = true,
					tabSize = 4,
					indentSize = 4,
					continuationIndentSize = 8,
				},
			},
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
		},
		signatureHelp = { enabled = true },
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
		},
		contentProvider = { preferred = "fernflower" },
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
	},

	init_options = {
		bundles = bundles,
	},

	capabilities = require("cmp_nvim_lsp").default_capabilities(),

	on_attach = function(client, bufnr)
		-- Enable DAP
		jdtls.setup_dap({ hotcodereplace = "auto" })

		-- Java-specific keymaps
		local opts = { buffer = bufnr, silent = true }

		-- LSP keymaps
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

		-- Mave run
		vim.keymap.set("n", "<leader>jr", function()
			vim.cmd("w") -- Save file first

			-- Utility function to find the Maven root directory by searching upwards for pom.xml
			local function find_maven_root()
				-- Search upwards up to 4 levels for pom.xml
				local pom_path = vim.fn.findfile("pom.xml", ".;..;../..;../../../..")
				if pom_path ~= "" then
					-- fnamemodify(path, ":h") gets the head (directory) of the path
					return vim.fn.fnamemodify(pom_path, ":h")
				end
				return nil
			end

			-- Utility function to extract the fully qualified class name (FQCN)
			local function get_fully_qualified_class_name()
				-- Read all lines of the current buffer
				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
				local package_name = nil
				local class_name = vim.fn.expand("%:t:r") -- e.g., "Main"

				for _, line in ipairs(lines) do
					-- Look for a line starting with 'package' and capture the package name (e.g., com.solutions)
					-- This regex ignores leading whitespace
					local match = line:match("^%s*package%s+([%w.]+);")
					if match then
						package_name = match
						break
					end
				end

				if package_name then
					-- FQCN: "com.solutions.Main"
					return package_name .. "." .. class_name
				else
					-- Default package: "Main"
					return class_name
				end
			end

			local file_path = vim.fn.expand("%:p")
			local maven_root = find_maven_root()

			if maven_root then
				-- --- Maven Project Logic ---
				-- 1. Get the FQCN by parsing the 'package' declaration.
				local fqcn = get_fully_qualified_class_name()
				-- 2. Define the classpath (where Maven compiles classes).
				local classpath = maven_root .. "/target/classes"

				-- 3. Construct the combined command:
				--    a) cd to the maven root
				--    b) Run 'mvn compile' to ensure the current class is in target/classes
				--    c) Execute the class directly using 'java -cp <classpath> <FQCN>'
				-- This is the robust, IDE-like behavior you were looking for.
				local cmd = string.format('cd %s && mvn compile && java -cp "%s" %s', maven_root, classpath, fqcn)
				vim.cmd("tabnew | term " .. cmd)
			else
				-- --- Non-Maven / Simple File Logic (Original Fallback) ---
				-- Compiles and runs a single file, only works for files without package declarations.
				local class_name = vim.fn.expand("%:t:r")
				local cmd = string.format(
					"cd %s && javac %s && java %s",
					vim.fn.fnamemodify(file_path, ":h"),
					vim.fn.expand("%:t"),
					class_name
				)
				vim.cmd("tabnew | term " .. cmd)
			end
		end, vim.tbl_extend("force", opts, { desc = "Run Java (w/ FQCN detection)" }))

		-- Runs the Project's configured main entry point.
		vim.keymap.set("n", "<leader>jmr", function()
			-- Save file first
			vim.cmd("w")

			-- Check if the project has a pom.xml
			local is_maven_project = vim.fn.filereadable("pom.xml")

			if is_maven_project then
				-- This command executes the class defined in the <mainClass> tag in pom.xml.
				-- It is the standard way to run an entire Maven-based application.
				vim.cmd("tabnew | term mvn compile exec:java")
			else
				-- Provide a message if not a Maven project
				vim.notify(
					"Not a Maven project (pom.xml not found). Cannot run project entry point.",
					vim.log.levels.WARN
				)
			end
		end, vim.tbl_extend("force", opts, { desc = "Run Project Main Class (via pom.xml)" }))

		-- Maven test
		vim.keymap.set("n", "<leader>jt", function()
			vim.cmd("tabnew | term mvn test")
		end, vim.tbl_extend("force", opts, { desc = "Run Maven tests" }))

		-- Maven Build
		vim.keymap.set("n", "<leader>jb", function()
			vim.cmd("tabnew | term mvn clean install")
		end, vim.tbl_extend("force", opts, { desc = "Build Maven project" }))

		-- Java-specific commands
		vim.keymap.set(
			"n",
			"<leader>jo",
			jdtls.organize_imports,
			vim.tbl_extend("force", opts, { desc = "Organize imports" })
		)
		vim.keymap.set(
			"n",
			"<leader>jv",
			jdtls.extract_variable,
			vim.tbl_extend("force", opts, { desc = "Extract variable" })
		)
		vim.keymap.set(
			"n",
			"<leader>jc",
			jdtls.extract_constant,
			vim.tbl_extend("force", opts, { desc = "Extract constant" })
		)
		vim.keymap.set(
			"v",
			"<leader>jm",
			[[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
			vim.tbl_extend("force", opts, { desc = "Extract method" })
		)

		-- Test commands
		vim.keymap.set("n", "<leader>tc", jdtls.test_class, vim.tbl_extend("force", opts, { desc = "Test class" }))
		vim.keymap.set(
			"n",
			"<leader>tm",
			jdtls.test_nearest_method,
			vim.tbl_extend("force", opts, { desc = "Test nearest method" })
		)
	end,
}

jdtls.start_or_attach(config)
