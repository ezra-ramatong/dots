#!/usr/bin/env bash

# Colors
GREEN='\033[1;32m'
RED='\033[1;31m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RESET='\033[0m'

# Default values
RUNS=10
COMMAND="npm run test"
DELAY=0

# Help function
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -n, --runs NUMBER     Number of test runs (default: 10)"
    echo "  -c, --command CMD     Command to run (default: 'npm run test')"
    echo "  -d, --delay SECONDS   Delay between runs (default: 0)"
    echo "  -h, --help           Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -n 5                    # Run 5 times"
    echo "  $0 -c 'npm test' -n 3      # Custom command, 3 runs"
    echo "  $0 -d 2                    # 2 second delay between runs"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--runs)
            RUNS="$2"
            shift 2
            ;;
        -c|--command)
            COMMAND="$2"
            shift 2
            ;;
        -d|--delay)
            DELAY="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Validate runs is a number
if ! [[ "$RUNS" =~ ^[0-9]+$ ]]; then
    echo -e "${RED}Error: Number of runs must be a positive integer${RESET}"
    exit 1
fi

# Statistics
PASSED=0
FAILED=0
START_TIME=$(date +%s)

echo -e "${CYAN}🚀 Starting test runner${RESET}"
echo -e "${BLUE}Command: ${COMMAND}${RESET}"
echo -e "${BLUE}Runs: ${RUNS}${RESET}"
if [ "$DELAY" -gt 0 ]; then
    echo -e "${BLUE}Delay: ${DELAY}s between runs${RESET}"
fi
echo ""

# Main loop
for ((i=1; i<=RUNS; i++)); do
    echo -e "${CYAN}===== Run $i/$RUNS =====${RESET}"
    
    if eval "$COMMAND"; then
        echo -e "${GREEN}✓ Run $i: PASSED${RESET}"
        ((PASSED++))
    else
        echo -e "${RED}✗ Run $i: FAILED${RESET}"
        ((FAILED++))
    fi
    
    echo ""
    
    # Add delay if specified (but not after the last run)
    if [ "$DELAY" -gt 0 ] && [ "$i" -lt "$RUNS" ]; then
        echo -e "${YELLOW}⏱️  Waiting ${DELAY}s...${RESET}"
        sleep "$DELAY"
        echo ""
    fi
done

# Final statistics
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

echo -e "${CYAN}📊 Test Summary${RESET}"
echo -e "${GREEN}✓ Passed: $PASSED${RESET}"
echo -e "${RED}✗ Failed: $FAILED${RESET}"
echo -e "${BLUE}⏱️  Total time: ${DURATION}s${RESET}"

if [ "$FAILED" -eq 0 ]; then
    echo -e "${GREEN}🎉 All tests passed!${RESET}"
    exit 0
else
    echo -e "${RED}💥 Some tests failed!${RESET}"
    exit 1
fi
