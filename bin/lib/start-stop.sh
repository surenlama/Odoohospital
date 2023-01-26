#!/bin/bash

# Created by argbash-init v2.8.0
# ARG_POSITIONAL_SINGLE([command],[Command],[])
# ARG_OPTIONAL_BOOLEAN([db-only],[],[Start database only])
# ARG_OPTIONAL_BOOLEAN([production],[],[Start production session])
# ARG_OPTIONAL_BOOLEAN([debug],[],[Start debug session])
# ARG_OPTIONAL_SINGLE([name],[n],[Service name],[web])
# ARG_OPTIONAL_SINGLE([database],[d],[Database])
# ARG_OPTIONAL_SINGLE([update],[u],[Update addons])
# ARG_OPTIONAL_SINGLE([install],[i],[Install addons])
# ARG_OPTIONAL_BOOLEAN([wsl],[],[Enable WSL support],[off])
# ARG_OPTIONAL_REPEATED([publish],[p],[Service ports])
# ARG_HELP([<Start or stop erp service>])
# ARG_LEFTOVERS([help text (optional)])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.10.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info


die()
{
	local _ret="${2:-1}"
	test "${_PRINT_HELP:-no}" = yes && print_help >&2
	echo "$1" >&2
	exit "${_ret}"
}


begins_with_short_option()
{
	local first_option all_short_options='nduiph'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
_arg_leftovers=()
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_db_only="off"
_arg_production="off"
_arg_debug="off"
_arg_name="web"
_arg_database=
_arg_update=
_arg_install=
_arg_wsl="off"
_arg_publish=()


print_help()
{
	printf '%s\n' "<Start or stop erp service>"
	printf 'Usage: %s [--(no-)db-only] [--(no-)production] [--(no-)debug] [-n|--name <arg>] [-d|--database <arg>] [-u|--update <arg>] [-i|--install <arg>] [--(no-)wsl] [-p|--publish <arg>] [-h|--help] <command> ... \n' "$0"
	printf '\t%s\n' "<command>: Command"
	printf '\t%s\n' "... : help text (optional)"
	printf '\t%s\n' "--db-only, --no-db-only: Start database only (off by default)"
	printf '\t%s\n' "--production, --no-production: Start production session (off by default)"
	printf '\t%s\n' "--debug, --no-debug: Start debug session (off by default)"
	printf '\t%s\n' "-n, --name: Service name (default: 'web')"
	printf '\t%s\n' "-d, --database: Database (no default)"
	printf '\t%s\n' "-u, --update: Update addons (no default)"
	printf '\t%s\n' "-i, --install: Install addons (no default)"
	printf '\t%s\n' "--wsl, --no-wsl: Enable WSL support (off by default)"
	printf '\t%s\n' "-p, --publish: Service ports (empty by default)"
	printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
	_positionals_count=0
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			--no-db-only|--db-only)
				_arg_db_only="on"
				test "${1:0:5}" = "--no-" && _arg_db_only="off"
				;;
			--no-production|--production)
				_arg_production="on"
				test "${1:0:5}" = "--no-" && _arg_production="off"
				;;
			--no-debug|--debug)
				_arg_debug="on"
				test "${1:0:5}" = "--no-" && _arg_debug="off"
				;;
			-n|--name)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_name="$2"
				shift
				;;
			--name=*)
				_arg_name="${_key##--name=}"
				;;
			-n*)
				_arg_name="${_key##-n}"
				;;
			-d|--database)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_database="$2"
				shift
				;;
			--database=*)
				_arg_database="${_key##--database=}"
				;;
			-d*)
				_arg_database="${_key##-d}"
				;;
			-u|--update)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_update="$2"
				shift
				;;
			--update=*)
				_arg_update="${_key##--update=}"
				;;
			-u*)
				_arg_update="${_key##-u}"
				;;
			-i|--install)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_install="$2"
				shift
				;;
			--install=*)
				_arg_install="${_key##--install=}"
				;;
			-i*)
				_arg_install="${_key##-i}"
				;;
			--no-wsl|--wsl)
				_arg_wsl="on"
				test "${1:0:5}" = "--no-" && _arg_wsl="off"
				;;
			-p|--publish)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_publish+=("$2")
				shift
				;;
			--publish=*)
				_arg_publish+=("${_key##--publish=}")
				;;
			-p*)
				_arg_publish+=("${_key##-p}")
				;;
			-h|--help)
				print_help
				exit 0
				;;
			-h*)
				print_help
				exit 0
				;;
			*)
				_last_positional="$1"
				_positionals+=("$_last_positional")
				_positionals_count=$((_positionals_count + 1))
				;;
		esac
		shift
	done
}


handle_passed_args_count()
{
	local _required_args_string="'command'"
	test "${_positionals_count}" -ge 1 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require at least 1 (namely: $_required_args_string), but got only ${_positionals_count}." 1
}


assign_positional_args()
{
	local _positional_name _shift_for=$1
	_positional_names="_arg_command "
	_our_args=$((${#_positionals[@]} - 1))
	for ((ii = 0; ii < _our_args; ii++))
	do
		_positional_names="$_positional_names _arg_leftovers[$((ii + 0))]"
	done

	shift "$_shift_for"
	for _positional_name in ${_positional_names}
	do
		test $# -gt 0 || break
		eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
		shift
	done
}

parse_commandline "$@"
handle_passed_args_count
assign_positional_args 1 "${_positionals[@]}"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash

ext_watcher=false
publish_ports=()
app_name=$(basename $PWD)
container_name="${app_name}_${_arg_name}"
on_trap="trap - INT TERM && docker-compose down"

if [ ${#_arg_publish} -eq 0 ]; then
  publish_ports=(--service-ports)
else
  for p in "${_arg_publish[@]}"; do publish_ports+=(-p $p); done
fi

if grep -q Microsoft /proc/version; then
  ext_watcher=true
fi

case $_arg_command in
  start )

    web_cmd=(web)
    run_cmd=()
    cmd=()

    if [ "$_arg_production" = "on" ]; then
      compose_cmd=(docker-compose)
      on_trap="trap - INT TERM && echo 'Success!'"

      if [ $_arg_update ]; then
        compose_cmd=(UPDATE=$(sed -e 's/addons\///g' -e 's/\///g' -e 's/,$//g' <<< $_arg_update) "${compose_cmd[@]}")
      fi

      ext_watcher=false

      cmd=("${compose_cmd[@]}" up -d)
    else
      compose_cmd=(docker-compose -f docker-compose.yml -f docker-compose.dev.yml)

      if [ "$_arg_debug" = "on" ]; then
        web_cmd+=(odoo-debug)
        run_cmd=("${compose_cmd[@]}" run)
      else
        web_cmd+=(odoo --dev all)
        run_cmd=("${compose_cmd[@]}" run)
      fi
    fi

    if [ "$_arg_db_only" = "on" ]; then
      on_trap="trap - INT TERM"
      cmd=("${compose_cmd[@]}" run --rm --no-deps "${publish_ports[@]}" db)
    fi

    run_cmd+=("${publish_ports[@]}")

    if [ $_arg_database ]; then
      web_cmd+=(-d $_arg_database)

      if [ $_arg_update ]; then
        web_cmd+=(-u $(sed -e 's/addons\///g' -e 's/\///g' -e 's/,$//g' <<< $_arg_update))
      fi

      if [ $_arg_install ]; then
        web_cmd+=(-i $(sed -e 's/addons\///g' -e 's/\///g' -e 's/,$//g' <<< $_arg_install))
      fi
    fi

    if [ ${#cmd} -eq 0 ]; then
      cmd=("${run_cmd[@]}" "${web_cmd[@]}" "${_arg_leftovers[@]}")
    fi

    if [ $ext_watcher = true ]; then
      on_trap="${on_trap[@]} && kill -- -\$\$"
      cmd=(docker-volume-watcher.exe $container_name 2\>/dev/null \& "${cmd[@]}")
    fi

    echo "${cmd[@]}"
    trap "${on_trap[@]}" INT TERM EXIT
    eval "${cmd[@]}"
    ;;
  stop )
    docker-compose down
  ;;
  * )
    print_help
    ;;
esac
# ] <-- needed because of Argbash
