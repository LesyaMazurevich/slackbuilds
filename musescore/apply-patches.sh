
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Use Fedora's default soundfont instead of the removed one:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-use-default-soundfont.patch
# We don't build the common files (font files, wallpapers, demo song, instrument
# list) into the binary executable to reduce its size. This is also useful to 
# inform the users about the existence of different choices for common files.
# The font files need to be separated due to the font packaging guidelines.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-separate-commonfiles-slk.patch
# Split the large documentation into a separate package
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-split-doc.patch
# Fix some gcc warnings
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-fix-gcc-warnings.patch
# Fix DSO linking. Seems to have fixed in trunk, but misssing in the tarball
# http://musescore.org/en/node/5817
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-dso-linking.patch
# Use system qtsingleapplication
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-system-qtsingleapplication.patch
# Fix crash on Accidentals click RHBZ#738044 From upstream trunk rev 3193
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-fix-accidentals-crash.patch

set +e +o pipefail
