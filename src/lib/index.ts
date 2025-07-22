// place files you want to import through the `$lib` alias in this folder.

export enum Vereniging {
    LOKO,
    Scientica,
    
    Atlas,
    BIOS,
    Chemika,
    Wina,

    Alfa,
    Historia,
}

export type Gebruiker =  {
    voornaam: string,
    achternaam: string,
    email: string,
    vereniging: Vereniging,
}

export type Shiftenlijst = {
    vereniging: Vereniging,
    naam: string,
    beschrijving?: string
    begin: Date,
    eind: Date,
    shiften: number,
    onopgevuld: number,

    beheerders: Gebruiker[]
}

export type Shift = {
    shiftenlijst?: Shiftenlijst,
    vereniging?: Vereniging
    
    naam: string,
    beschrijving?: string,
    locatie: string
    begin: Date,
    duur: number,
    maxShifters?: number,
    maxVrijwilligers?: number,
    combineerbaar: boolean,

    ingevuldDoor: Gebruiker[]
}

export type HerhaaldeShift = {
    shift: Shift,
    herhalingen: number
}