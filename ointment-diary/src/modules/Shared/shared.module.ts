import { ArchiveUploadModule } from './FileUpload/archive-upload.module';
import { Module } from '@nestjs/common';

@Module({
    imports: [ArchiveUploadModule],
    exports: [ArchiveUploadModule],
})
export class SharedModule {}
