import { Body, Controller, Post, Request } from '@nestjs/common';
import { CalendaryService } from './calendary.service';
import { GetCalendary } from './calendary.dto';

@Controller('calendary')
export class CalendaryController {
    constructor(private readonly calendaryService: CalendaryService) {}

    @Post()
    async findByUserId(@Request() request, @Body() body: GetCalendary) {
        return await this.calendaryService.findByUserId(request.user._id, body);
    }
}
