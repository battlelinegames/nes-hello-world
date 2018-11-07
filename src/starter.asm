.linecont       +               ; Allow line continuations
.feature        c_comments      /* allow this style of comment */

.segment "IMG"
.incbin "../img/HelloWorld.chr"

.include "./def/header.asm"
.include "./lib/utils.asm"
.include "./lib/gamepad.asm"
.include "./def/ppu.asm"
.include "./def/palette.asm"

.include "./lib/hello_world.asm"          ; this is application specific hello_world stuff

.include "./vectors/irq.asm"              ; not currently using irq code, but it must be defined
.include "./vectors/reset.asm"            ; code and macros related to pressing the reset button
.include "./vectors/nmi.asm"


game_loop:
    lda nmi_ready
    bne game_loop

    jsr set_gamepad

    set nmi_ready, #1
    jmp game_loop