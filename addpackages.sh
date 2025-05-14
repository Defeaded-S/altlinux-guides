#!/bin/sh
REPO_DIR="$1"
REPO_NAME="$2"
PACKAGES_DIR="$3"
 
#Arguments: <path_to_first_packet> <path_to_second_packet> <rpm_attr_to_compare (EPOCH, VERSION, RELEASE)>
cmp_packets_attr(){
    if [ $# -lt 3 ];then
        echo "cmp_packets_attr: needs 3 arguments"
        exit 4
    fi
    f1="$1"
    f2="$2"
    attr="$3"
    a1=`rpm -qp --queryformat "%{$attr}" $f1`
    a2=`rpm -qp --queryformat "%{$attr}" $f2`
    zero="(none)"
    if [ "$a1" = "$zero" -a "$a2" != "$zero" ]; then
        return -1
    fi
    if [ "$a1" != "$zero" -a "$a2" = "$zero" ]; then
        return 1
    fi
    return `/usr/bin/rpmevrcmp $a1 $a2`
}

#Arguments: <path_to_first_packet> <path_to_second_packet>
cmp_packets(){
    if [ -z "$1" -o -z "$2" ];then
        echo "cmp_packets: needs 2 argument"
        exit 3
    fi
    f1="$1"
    f2="$2"
    for attr in EPOCH SERIAL VERSION RELEASE; do
	cmp_packets_attr "$f1" "$f2" $attr
	if [ ! $? -eq 0 ];then
	    return $?
	fi
    done
    return $?
}

pkglst=`/usr/bin/packages $PACKAGES_DIR | sort -u -k1,1 | cut -f3`
for pkg in $pkglst; do
    file="$PACKAGES_DIR/$pkg"
    arch=`rpm -qp --queryformat %{ARCH} "$file"`
    rpm_name=`rpm -qp --queryformat %{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}.rpm "$file"`
    tofile="$REPO_DIR/$arch/RPMS.$REPO_NAME/$rpm_name"
    if [ ! -e $tofile ];then
        cp "$file" "$tofile"
        continue
    fi
    cmp_packets "$file" "$tofile"
    if [ $? -gt 0 ];then
        cp -f "$file" "$tofile"
    fi
done
