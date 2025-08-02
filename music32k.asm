; Win32 API
EXTERN __imp__MessageBoxA@16
%define MessageBox [__imp__MessageBoxA@16]
EXTERN __imp__ExitProcess@4
%define ExitProcess [__imp__ExitProcess@4]

; uFMOD (WINMM)
%include "ufmod.inc"

section .text

; Let's place the stream right inside the code section.
xm         incbin "music32k.xm"
xm_length  equ $-xm
MsgCaption db "xmexe32k",0
MsgBoxText db "Hello World!",0

GLOBAL _start
_start:
	; EBX = 0
	xor ebx,ebx

	; Start playback.
	push XM_MEMORY
	push xm_length
	push xm
	call uFMOD_PlaySong

	; Wait for user input.
	push ebx
	push MsgCaption
	push MsgBoxText
	push ebx
	call MessageBox

	; Stop playback.
	push ebx
	push ebx
	push ebx
	call uFMOD_PlaySong

	push ebx
	call ExitProcess