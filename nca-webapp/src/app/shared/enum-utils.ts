export class EnumUtils {

    public static toMap(enumType: { [s: number]: string }):
    Map<number, string> {
    const enumValues = new Map();
    const enumKeys = Object.keys(enumType);
    for (const enumKey of enumKeys.slice(enumKeys.length / 2)) {
        const correctEnum: number = enumType[enumKey];
        enumValues.set(correctEnum, enumType[correctEnum]);
    }
    return enumValues;
}

    public static toStringArray(enumType: { [s: number]: string }): string[] {
        const enumValues = [];
        const enumKeys = Object.keys(enumType);
        for (const enumKey of enumKeys.slice(enumKeys.length / 2)) {
            const correctEnum: number = enumType[enumKey];
            enumValues.push(enumType[correctEnum]);
        }
        return enumValues;
    }

}