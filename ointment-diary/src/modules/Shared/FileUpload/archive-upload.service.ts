import { ArchiveUpload } from './archive-upload.model';
import { MemoryStoredFile } from 'nestjs-form-data';
import { Injectable } from '@nestjs/common';
import { extname } from 'path';

@Injectable()
export class ArchiveUploadService {
    /**
     * Read file to upload.
     *
     * @async
     * @function up
     * @param { MemoryStoredFile } archive The file to be read.
     * @return { Promise<ArchiveUpload> } The file read.
     * @throws { Error } Reading mistake
     */
    public async up(archive: MemoryStoredFile): Promise<ArchiveUpload> {
        try {
            const encoding = 'base64';
            const { originalName, mimetype, buffer, size } = archive;
            const filename = new Date().getTime() + extname(originalName);
            const file = buffer.toString(encoding);
            await archive.delete();
            return {
                originalName,
                filename,
                mimetype,
                encoding,
                file,
                size,
            };
        } catch (e) {
            throw new Error('Não foi possível salvar o arquivo enviado.');
        }
    }
}
