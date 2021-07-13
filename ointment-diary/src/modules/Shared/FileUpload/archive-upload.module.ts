import { ArchiveUploadService } from './archive-upload.service';
import { Module } from '@nestjs/common';

@Module({
    providers: [ArchiveUploadService],
    exports: [ArchiveUploadService],
})
export class ArchiveUploadModule {}
