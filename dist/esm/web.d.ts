import { WebPlugin } from '@capacitor/core';
import { HeartlandFormPlugin } from './definitions';
export declare class HeartlandFormWeb extends WebPlugin implements HeartlandFormPlugin {
    constructor();
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
    open(options: {
        heartlandPublicKey: string;
    }): Promise<{
        heartlandPublicKey: string;
    }>;
}
declare const HeartlandForm: HeartlandFormWeb;
export { HeartlandForm };
