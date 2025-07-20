-- HUGO / GO TEMPLATES
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

return {
	-- Basic curly braces
	s("x", {
		t("{{ "),
		i(1),
		t(" }}"),
	}),

	-- Dot context
	s("xx", {
		t("{{ . }}"),
	}),

	-- If statement
	s("if", {
		t("{{ if "),
		i(1, ".Condition"),
		t(" }}"),
		t({ "", "  " }),
		i(0),
		t({ "", "{{ end }}" }),
	}),

	-- If inline
	s("ifi", {
		t("{{ if "),
		i(1, ".Condition"),
		t(" }}"),
		i(2),
		t("{{ end }}"),
	}),

	-- If/Else
	s("ife", {
		t("{{ if "),
		i(1, ".Condition"),
		t(" }}"),
		t({ "", "  " }),
		i(2),
		t({ "", "{{ else }}" }),
		t({ "", "  " }),
		i(3),
		t({ "", "{{ end }}" }),
	}),

	-- If/Else if
	s("ifei", {
		t("{{ if "),
		i(1, ".Condition1"),
		t(" }}"),
		t({ "", "  " }),
		i(2),
		t({ "", "{{ else if " }),
		i(3, ".Condition2"),
		t(" }}"),
		t({ "", "  " }),
		i(4),
		t({ "", "{{ end }}" }),
	}),

	-- With
	s("with", {
		t("{{ with "),
		i(1, ".Data"),
		t(" }}"),
		t({ "", "  " }),
		i(0),
		t({ "", "{{ end }}" }),
	}),

	-- With/Else
	s("withe", {
		t("{{ with "),
		i(1, ".Data"),
		t(" }}"),
		t({ "", "  " }),
		i(2),
		t({ "", "{{ else }}" }),
		t({ "", "  " }),
		i(3),
		t({ "", "{{ end }}" }),
	}),

	-- Range
	s("range", {
		t("{{ range "),
		i(1, ".Items"),
		t(" }}"),
		t({ "", "  " }),
		i(0),
		t({ "", "{{ end }}" }),
	}),

	-- Range with variables
	s("rangev", {
		t("{{ range $"),
		i(1, "index"),
		t(", $"),
		i(2, "item"),
		t(" := "),
		i(3, ".Items"),
		t(" }}"),
		t({ "", "  " }),
		i(0),
		t({ "", "{{ end }}" }),
	}),

	-- Partial
	s("partial", {
		t('{{ partial "'),
		i(1, "name.html"),
		t('" '),
		i(2, "."),
		t(" }}"),
	}),

	-- Partial cached
	s("partialc", {
		t('{{ partialCached "'),
		i(1, "name.html"),
		t('" '),
		i(2, "."),
		t(" "),
		i(3, "variant"),
		t(" }}"),
	}),

	-- Naked partial (without curly braces)
	s("xpartial", {
		t('partial "'),
		i(1, "name.html"),
		t('" '),
		i(2, "."),
	}),

	-- Block
	s("block", {
		t('{{ block "'),
		i(1, "main"),
		t('" '),
		i(2, "."),
		t(" }}"),
		t({ "", "  " }),
		i(0),
		t({ "", "{{ end }}" }),
	}),

	-- Define
	s("define", {
		t('{{ define "'),
		i(1, "block"),
		t('" }}'),
		t({ "", "  " }),
		i(0),
		t({ "", "{{ end }}" }),
	}),

	-- Scratch operations
	s("scra", {
		t("{{ .Scratch."),
		c(1, {
			t('Set "'),
			i(1, "key"),
			t('" '),
			i(2, "value"),
			t('Get "'),
			i(1, "key"),
			t('"'),
			t('Add "'),
			i(1, "key"),
			t('" '),
			i(2, "value"),
			t('SetInMap "'),
			i(1, "key"),
			t('" "'),
			i(2, "mapkey"),
			t('" '),
			i(3, "value"),
			t('Delete "'),
			i(1, "key"),
			t('"'),
			t('GetSortedMapValues "'),
			i(1, "key"),
			t('"'),
		}),
		t(" }}"),
	}),

	-- String formatting
	s("str", {
		t('{{ printf "'),
		i(1, "Something about %s"),
		t('" '),
		i(2, "."),
		t(" }}"),
	}),

	-- Printf with common formats
	s("print", {
		t('{{ printf "'),
		c(1, {
			t("%s"),
			t("%v"),
			t("%d"),
			t("%x"),
			t("%t"),
			t("%f"),
		}),
		t('" '),
		i(2, "."),
		t(" }}"),
	}),

	-- Variable assignment
	s("vars", {
		t("{{ $"),
		i(1, "var"),
		t(" := "),
		i(2, "what"),
		t(" }}"),
	}),

	-- Return statement
	s("ret", {
		t("{{ return "),
		i(1, "$return"),
		t(" }}"),
	}),

	-- Debug
	s("debug", {
		t('{{ printf "%#v" '),
		i(1, "."),
		t(" }}"),
	}),

	-- Error
	s("error", {
		t('{{ errorf "'),
		i(1, "%#v"),
		t('" '),
		i(2, "."),
		t(" }}"),
	}),

	-- Comment
	s("comm", {
		t("{{/* "),
		i(1, "comment"),
		t(" */}}"),
	}),

	-- Hugo-specific functions
	s("url", {
		t("{{ .Permalink }}"),
	}),

	s("title", {
		t("{{ .Title }}"),
	}),

	s("content", {
		t("{{ .Content }}"),
	}),

	s("summary", {
		t("{{ .Summary }}"),
	}),

	s("date", {
		t('{{ .Date.Format "'),
		i(1, "2006-01-02"),
		t('" }}'),
	}),

	-- Site variables
	s("site", {
		t("{{ .Site."),
		c(1, {
			t("Title"),
			t("BaseURL"),
			t("Params."),
			i(1, "param"),
			t("Pages"),
			t("RegularPages"),
			t("Menus."),
			i(1, "main"),
		}),
		t(" }}"),
	}),

	-- Page resources
	s("resources", {
		t("{{ range .Resources }}"),
		t({ "", "  " }),
		i(0),
		t({ "", "{{ end }}" }),
	}),

	-- Image processing
	s("resize", {
		t('{{ $img := .Resources.GetMatch "'),
		i(1, "image.jpg"),
		t('" }}'),
		t({ "", '{{ $resized := $img.Resize "' }),
		i(2, "300x"),
		t('" }}'),
		t({ "", '<img src="{{ $resized.RelPermalink }}" alt="' }),
		i(3, "alt text"),
		t('" />'),
	}),

	-- Shortcode
	s("short", {
		t("{{< "),
		i(1, "shortcode"),
		t(" >}}"),
	}),

	-- Shortcode with params
	s("shortp", {
		t("{{< "),
		i(1, "shortcode"),
		t(" "),
		i(2, 'param="value"'),
		t(" >}}"),
	}),

	-- Closing shortcode
	s("shortc", {
		t("{{< "),
		i(1, "shortcode"),
		t(" >}}"),
		t({ "", "  " }),
		i(2),
		t({ "", "{{< /" }),
		f(function(args)
			return args[1][1]
		end, { 1 }),
		t(" >}}"),
	}),

	-- Common Hugo functions
	s("len", {
		t("{{ len "),
		i(1, ".Pages"),
		t(" }}"),
	}),

	s("where", {
		t("{{ range where "),
		i(1, ".Pages"),
		t(' "'),
		i(2, "Type"),
		t('" "'),
		i(3, "post"),
		t('" }}'),
		t({ "", "  " }),
		i(0),
		t({ "", "{{ end }}" }),
	}),

	s("first", {
		t("{{ range first "),
		i(1, "5"),
		t(" "),
		i(2, ".Pages"),
		t(" }}"),
		t({ "", "  " }),
		i(0),
		t({ "", "{{ end }}" }),
	}),

	-- Template inheritance
	s("extend", {
		t('{{ define "main" }}'),
		t({ "", "  " }),
		i(0),
		t({ "", "{{ end }}" }),
	}),

	-- Common patterns
	s("menu", {
		t("{{ range .Site.Menus."),
		i(1, "main"),
		t(" }}"),
		t({ "", '  <a href="{{ .URL }}">{{ .Name }}</a>' }),
		t({ "", "{{ end }}" }),
	}),

	s("pagination", {
		t("{{ if .Paginator.HasPrev }}"),
		t({ "", '  <a href="{{ .Paginator.Prev.URL }}">Previous</a>' }),
		t({ "", "{{ end }}" }),
		t({ "", "{{ if .Paginator.HasNext }}" }),
		t({ "", '  <a href="{{ .Paginator.Next.URL }}">Next</a>' }),
		t({ "", "{{ end }}" }),
	}),
}
