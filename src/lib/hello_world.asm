
; this code will be called from the nmi
.macro printf_nmi STRING, XPOS, YPOS ; 32, 128
    .local ROW
    .local COL
    .local BYTE_OFFSET_HI
    .local BYTE_OFFSET_LO
    
    ROW = YPOS / 8 ; 128 / 8 = 16
    COL = XPOS / 8 ; 32 /  8  = 4
    BYTE_OFFSET_HI = (ROW * 32 + COL) / 256 + 32 ; (16 * 32 + 4) / 256 + 20
    BYTE_OFFSET_LO = (ROW * 32 + COL) .mod 256

    lda PPU_STATUS        ; PPU_STATUS = $2002

    lda #BYTE_OFFSET_HI
    sta PPU_ADDR          ; PPU_ADDR = $2006
    lda #BYTE_OFFSET_LO
    sta PPU_ADDR          ; PPU_ADDR = $2006

    .repeat .strlen(STRING), I
        lda #.strat(STRING, I)
        sta PPU_DATA      
    .endrep
.endmacro