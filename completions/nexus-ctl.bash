# bash completion for nexus-ctl
# https://github.com/digitaldesignerjazz/nexus-control-panel

_nexus_ctl() {
    local cur prev opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # All top-level categories
    local categories="mesh agents blockchain hardware system completion help version"

    # mesh actions
    local mesh_actions="status restart peer config monitor privacy qnet"

    # agents actions
    local agents_actions="list deploy scale introspect improve assign log"

    # blockchain actions
    local blockchain_actions="status tx arbitrage qnet rune monitor"

    # hardware actions
    local hardware_actions="status control flash calibrate grok-launcher monitor"

    # system actions
    local system_actions="status logs auth backup privacy-audit orchestrate"

    case "${prev}" in
        nexus-ctl)
            COMPREPLY=( $(compgen -W "${categories}" -- ${cur}) )
            return 0
            ;;
        mesh)
            COMPREPLY=( $(compgen -W "${mesh_actions}" -- ${cur}) )
            return 0
            ;;
        agents)
            COMPREPLY=( $(compgen -W "${agents_actions}" -- ${cur}) )
            return 0
            ;;
        blockchain)
            COMPREPLY=( $(compgen -W "${blockchain_actions}" -- ${cur}) )
            return 0
            ;;
        hardware)
            COMPREPLY=( $(compgen -W "${hardware_actions}" -- ${cur}) )
            return 0
            ;;
        system)
            COMPREPLY=( $(compgen -W "${system_actions}" -- ${cur}) )
            return 0
            ;;
        --service)
            # Common services for mesh restart
            COMPREPLY=( $(compgen -W "yggdrasil tenda nova docker" -- ${cur}) )
            return 0
            ;;
        --coin)
            COMPREPLY=( $(compgen -W "xcoin qcoin" -- ${cur}) )
            return 0
            ;;
    esac

    # Global options
    opts="--help --version --dry-run --json --verbose -v"
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _nexus_ctl nexus-ctl
