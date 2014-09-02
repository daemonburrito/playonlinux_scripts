#!/usr/bin/env bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="ultima_456"
PREFIX="Ultima456_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Ultima 4, 5, 6"
DEVELOPER="Origin Systems / Electronic Arts"
INSTALL_FILE_HASH="ce753da8c97e34473f281591eaf7f45a"
INSTALL_DIR="Ultima Second Trilogy"
GAME_DIR1="Ultima 4"
GAME_DIR2="Ultima 5"
GAME_DIR3="Ultima 6"
GAME_DIR1_SHORT="Ultima4"
GAME_DIR2_SHORT="Ultima5"
GAME_DIR3_SHORT="Ultima6"

EXEC1="ULTIMA.COM"
EXEC2="ULTIMA.EXE"
EXEC3="ULTIMA6.EXE"
MANUAL1="manual.pdf"
MANUAL2="manual.pdf"
MANUAL3="manual.pdf"
SHORTCUT_NAME1="Ultima 4: Quest of the Avatar (Bundled)"
SHORTCUT_NAME2="Ultima 5: Warriors of Destiny"
SHORTCUT_NAME3="Ultima 6: The False Prophet"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$DEVELOPER" "http://www.gog.com/gamecard/$GOGID" "daemonburrito" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "$INSTALL_FILE_HASH"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
cpu_core=auto
cpu_cycles=500
dosbox_memsize=16
sblaster_sbtype=sbpro1
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
_EOFCFG_

[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

POL_SetupWindow_wait "Moving game dirs to shortened names" "$TITLE"
# workaround for shortize bug
cd "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR"
ln -s "$GAME_DIR1" "$GAME_DIR1_SHORT"
ln -s "$GAME_DIR2" "$GAME_DIR2_SHORT"
ln -s "$GAME_DIR3" "$GAME_DIR3_SHORT"
cd "$WINEPREFIX/drive_c/"

POL_Shortcut "GOG Games/$INSTALL_DIR/$GAME_DIR1_SHORT/$EXEC1" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR/$GAME_DIR1/$MANUAL1"
 
POL_Shortcut "GOG Games/$INSTALL_DIR/$GAME_DIR2_SHORT/$EXEC2" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR/$GAME_DIR2/$MANUAL2"
 
POL_Shortcut "GOG Games/$INSTALL_DIR/$GAME_DIR3_SHORT/$EXEC3" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR/$GAME_DIR3/$MANUAL3"
 
POL_SetupWindow_Close

exit 0
