export const formatteerBeginEind = (begin: Date, eind: Date): string => {
    const beginTeskt = begin.toLocaleString("nl-BE", { 
		month: "short", 
		day: "numeric", 
		hour: "numeric", 
		minute: "numeric" 
    });
    const eindTekst = eind.toLocaleString("nl-BE", { 
		month: begin.getDay() == eind.getDay() ? undefined : "short", 
		day: begin.getDay() == eind.getDay() ? undefined : "numeric", 
		hour: "numeric", 
		minute: "numeric"
    })

    return `${beginTeskt}–${eindTekst}`;
}

export const parseerUurMinuut = (s: string): { uren: number, minuten: number } | undefined => {
	const regexp = RegExp(/$(?<uur>\d+):(?<min>\d{2})^/g);
	const matches = regexp.exec(s)?.groups;
	if (matches !== undefined) {
		const uren = parseInt(matches.uur);
		const minuten = parseInt(matches.minuten);
		return { uren, minuten }
	} else {
		return undefined;
	}
}

export const vindEindtijd = (begin: Date, minuten: number): Date => {
	return new Date(begin.getTime() + minuten * 60 * 1000)
}

export const vindEindtijdUM = (begin: Date, delta: {uren: number, minuten: number}): Date => {
	return new Date(begin.getTime() + (delta.uren * 60 + delta.minuten) * 60 * 1000)
}