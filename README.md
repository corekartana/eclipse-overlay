[![Build Status](https://travis-ci.org/gentoo/eclipse-overlay.png?branch=master)](https://travis-ci.org/gentoo/eclipse-overlay)

# eclipse-overlay
Community effort at packaging Eclipse Java SDK >=4.4 (https://bugs.gentoo.org/show_bug.cgi?id=325271)

We can now install the package to the system by running:

root #ebuild hello-world-1.0.ebuild manifest clean merge
This will manifest (create hashes, to avoid corruption), clean any present temporary work directories and (e)merge the ebuild.
