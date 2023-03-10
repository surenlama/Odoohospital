#!/bin/bash

# Created by argbash-init v2.8.0
# ARG_POSITIONAL_SINGLE([database],[Odoo database])
# ARG_POSITIONAL_INF([addons],[Comma separated Odoo addons],[1])
# ARG_OPTIONAL_SINGLE([user],[u],[Database user],[\\\$USER])
# ARG_OPTIONAL_SINGLE([password],[w],[Database password])
# ARG_OPTIONAL_SINGLE([db-host],[o],[Database host],[\\\$HOST])
# ARG_HELP([Upgrade odoo addons for selected database])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.8.1 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info


die()
{
	local _ret=$2
	test -n "$_ret" || _ret=1
	test "$_PRINT_HELP" = yes && print_help >&2
	echo "$1" >&2
	exit ${_ret}
}


begins_with_short_option()
{
	local first_option all_short_options='uwoh'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
_arg_addons=('' )
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_user="\\\$USER"
_arg_password=
_arg_db_host="\\\$HOST"


print_help()
{
	printf '%s\n' "Upgrade odoo addons for selected database"
	printf 'Usage: %s [-u|--user <arg>] [-w|--password <arg>] [-o|--db-host <arg>] [-h|--help] <database> <addons-1> [<addons-2>] ... [<addons-n>] ...\n' "$0"
	printf '\t%s\n' "<database>: Odoo database"
	printf '\t%s\n' "<addons>: Comma separated Odoo addons"
	printf '\t%s\n' "-u, --user: Database user (default: '\\\$USER')"
	printf '\t%s\n' "-w, --password: Database password (no default)"
	printf '\t%s\n' "-o, --db-host: Database host (default: '\\\$HOST')"
	printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
	_positionals_count=0
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			-u|--user)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_user="$2"
				shift
				;;
			--user=*)
				_arg_user="${_key##--user=}"
				;;
			-u*)
				_arg_user="${_key##-u}"
				;;
			-w|--password)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_password="$2"
				shift
				;;
			--password=*)
				_arg_password="${_key##--password=}"
				;;
			-w*)
				_arg_password="${_key##-w}"
				;;
			-o|--db-host)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_db_host="$2"
				shift
				;;
			--db-host=*)
				_arg_db_host="${_key##--db-host=}"
				;;
			-o*)
				_arg_db_host="${_key##-o}"
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
	local _required_args_string="'database' and 'addons'"
	test "${_positionals_count}" -ge 2 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require at least 2 (namely: $_required_args_string), but got only ${_positionals_count}." 1
}


assign_positional_args()
{
	local _positional_name _shift_for=$1
	_positional_names="_arg_database _arg_addons "
	_our_args=$((${#_positionals[@]} - 2))
	for ((ii = 0; ii < _our_args; ii++))
	do
		_positional_names="$_positional_names _arg_addons[$((ii + 1))]"
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

function join_by { local IFS="$1"; shift; echo "$*"; }

addons=$(join_by , "${_arg_addons[@]}")
addons=$(sed -e 's/addons\///g' -e 's/\///g' -e 's/,$//g' <<< $addons)

password=${_arg_password:-"\\\$(cat \\\$PASSWORD_FILE)"}
cmd="docker-compose run --rm --no-deps
  -e COLUMNS=$(tput cols)
  -e LINES=$(tput lines)
  web
  /bin/bash -c \"reset -w && odoo -d $_arg_database -w $password  -r $_arg_user --db_host $_arg_db_host -u $addons --stop-after-init\""

echo $cmd
eval $cmd

# ] <-- needed because of Argbash
