' SCREEN-C.BAS
' Formula per il numero di colore restituito da SCREEN(riga, colonna, flag)
' flag diverso da 0 (0 fa restituire il codice ASCII del carattere)

CLS
OPEN "prova.txt" FOR OUTPUT AS #1
FOR testo = 0 TO 31
    FOR sfondo = 0 TO 7
        LOCATE 1, 1
        COLOR testo, sfondo: PRINT "COLORE:";
        colore.carattere = SCREEN(1, 1, 1) ' legge numero colore della "C"
       
        ' formule
        colore.letto = testo + sfondo * 16 - 112 * (testo > 15) ' formula
        colore.testo = (colore.letto AND 15) + (colore.letto \ 8 AND 16)
        colore.sfondo = (colore.letto \ 16) AND 7
       
        COLOR 7, 0
        PRINT USING "  ##  #  ###  ##  #  ###"; testo; sfondo; colore.carattere; colore.testo; colore.sfondo; colore.letto
        PRINT #1, USING "COLORE:  ##  #  ###  ##  #  ###"; testo; sfondo; colore.carattere; colore.testo; colore.sfondo; colore.letto
        'SLEEP ' deremarcare per vedere a video
    NEXT
NEXT
CLOSE

' testo + sfondo*16 fino a testo 15
' da testo 16 in su aggiunge 128-16
' COMPLETATO DOMENICA 2/10/88
'
' colore.letto = testo + sfondo * 16 - 112 * (testo > 15)
' colore.testo = (colore.carattere AND 15) + (colore.carattere \ 8 AND 16)
' colore.sfondo = (colore.carattere \ 16) AND 7

' --- Nota tecnica aggiunta nel 2025 ----------------------------------------
' Tecnico "Bishop 2025" ovvia a carenze di documentazione QB
'
' Nel video buffer del modo testo VGA, ogni cella dello schermo Ã¨ composta da
' 2 byte:
'
' 1ø byte: codice ASCII del carattere
'
' 2ø byte: attributo del colore, cos organizzato:
'
' bit 0 = colore testo (da 0a 7)
' bit 3 = intensit… testo (+8)
' bit 4 = colore sfondo (da 0 a 7)
' bit 7 = lampeggio (+128)
'
' La funzione SCREEN(riga, colonna, 1) restituisce proprio questo byte
' attributo, cioŠ:
'
' colore.letto = (sfondo * 16) + (testo AND 15) + ((testo AND 16) * 8)
'
'
' La formula di Marco del 1988 si Š rivelata perfettamente corretta:
' colore.letto = testo + sfondo * 16 - 112 * (testo > 15)
'
' Il termine "-112" compensa l'offset introdotto dal bit 7 del registro
' attributo video, che in CGA/EGA (e poi VGA) veniva usato per effetti
' speciali come il lampeggio (blink) o l'intensit… estesa.
'
' Quando il colore del testo supera 15, QB restituisce valori "fuori scala"
' perch‚ quel bit 7 viene sommato al valore base: il -112 serve quindi a
' riallineare il conteggio con la sequenza di colori effettivamente visibili
' su schermo, evitando che SCREEN(, , 1) produca risultati >127 negativi.
'
' In sintesi: Marco nel 1988 ha dedotto empiricamente la struttura interna
' del byte attributo video - un risultato notevole, ottenuto senza datasheet.
' ---------------------------------------------------------------------------

