import { corsOrigins } from "./origins";

export const corsConfig = {
    origin: corsOrigins,
    credentials: true,
    optionsSuccessStatus: 200,
} 