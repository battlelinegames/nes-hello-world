.segment "CODE"

; this is like a x = y call where x is set to the value of y
.macro set set_var, from
    lda from
    sta set_var
.endmacro

; this procedure will loop until the next vblank
.proc wait_for_vblank
	bit PPU_STATUS      ; $2002
    vblank_wait:
		bit PPU_STATUS  ; $2002
		bpl vblank_wait

    rts
.endproc

; clear out all the ram on the reset press
.macro clear_ram
	lda #0
	ldx #0
	clear_ram_loop:
		sta $0000, X
		sta $0100, X 
		sta $0200, X
		sta $0300, X
		sta $0400, X
		sta $0500, X
		sta $0600, X
		sta $0700, X
		inx
		bne clear_ram_loop
.endmacro

