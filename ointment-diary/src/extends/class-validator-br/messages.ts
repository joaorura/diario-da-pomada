export const IsStringMessage = 'A propriedade $property precisa ser um texto.';
export const IsBooleanMessage = 'A propriedade $property precisa ser um booleano.';
export const IsEmailMessage = 'A propriedade $property precisa ser um e-mail válido.';
export const IsNumberStringMessage = 'A propriedade $property precisa ser um número.';
export const IsNotEmptyMessage = 'A propriedade $property é obrigatória: não pode ser vazia.';
export const IsStringNullMessage = 'A propriedade $property precisa ser um texto ou ser nula.';
export const IsFileMessage = 'A propriedade $property é obrigatória: precisa possuir um arquivo.';
export const IsPositiveMessage = 'A propriedade $property precisa ser um número inteiro positivo.';
export const FixedLengthMessage = 'A propriedade $property precisa possuir $constraint1 caracteres.';
export const IsMongoIdMessage = 'A propriedade $property precisa ser um identificador MongoDB válido.';
export const MinLengthMessage = 'A propriedade $property precisar possuir $constraint1 ou mais caracteres.';
export const MaxLengthMessage = 'A propriedade $property precisar possuir $constraint1 ou menos caracteres.';
export const IsDateOnlyMessage = 'A propriedade $property precisa ser uma data válida no formato YYYY-MM-DD.';
export const MaxFileSizeMessage = 'A propriedade $property precisa ser menor ou igual ao tamanho máximo: $constraint1 bytes.';
export const HasMimeTypeMessage = (mimeTypes: string[]) => {
    return `A propriedade $property precisa ser ${mimeTypes.toString().replace(/,/g, ', ')}.`;
};
