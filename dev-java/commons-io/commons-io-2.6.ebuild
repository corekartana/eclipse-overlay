# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 eutils

MY_P=${P}-src
DESCRIPTION="Utility classes, stream implementations, file filters, endian classes"
HOMEPAGE="http://commons.apache.org/io/"
SRC_URI="http://archive.apache.org/dist/commons/io/source/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=virtual/jre-1.7"
DEPEND=">=virtual/jdk-1.7
	test? (
		dev-java/ant-junit:0
		dev-java/junit:4
	)"

S=${WORKDIR}/${MY_P}

EANT_EXTRA_ARGS="-Dcomponent.version=${PV}"
JAVA_ANT_REWRITE_CLASSPATH="yes"

#java_prepare() {
	# Setting java.io.tmpdir doesn't have effect unless we do this because the vm is forked
#	java-ant_xml-rewrite -f build.xml --change -e junit -a clonevm -v "true"
#}

src_test() {
	if [[ ${EUID} -ne 0 ]] ; then
		ANT_OPTS="-Dskip.download=1 -Djava.io.tmpdir=${T} -Duser.home=${T}" \
		ANT_TASKS="ant-junit" \
			eant test \
			-Dgentoo.classpath="$(java-pkg_getjars junit-4):${S}/src/test/resources" \
			-Dlibdir="libdir" \
			-Djava.io.tmpdir="${T}"
	else
		elog "Tests fail unless userpriv is enabled because they test for"
		elog "file permissions which doesn't work when run as root."
	fi
}

src_install() {
	java-pkg_newjar target/${P}.jar

	dodoc RELEASE-NOTES.txt
	use doc && java-pkg_dojavadoc target/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
