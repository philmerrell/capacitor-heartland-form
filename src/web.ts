import { WebPlugin } from '@capacitor/core';
import { HeartlandFormPlugin } from './definitions';

export class HeartlandFormWeb extends WebPlugin implements HeartlandFormPlugin {
  constructor() {
    super({
      name: 'HeartlandForm',
      platforms: ['web']
    });
  }

  async echo(options: { value: string }): Promise<{value: string}> {
    console.log('ECHO', options);
    return Promise.resolve({ value: options.value });
  }

  async open(options: { heartlandPublicKey: string}): Promise<{heartlandPublicKey: string}> {
    return Promise.resolve({ heartlandPublicKey: options.heartlandPublicKey})
  }

}

const HeartlandForm = new HeartlandFormWeb();

export { HeartlandForm };
