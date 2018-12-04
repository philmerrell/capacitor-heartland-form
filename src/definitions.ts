declare global {
  interface PluginRegistry {
    HeartlandForm?: HeartlandFormPlugin;
  }
}

export interface HeartlandFormPlugin {
  echo(options: { value: string }): Promise<{value: string}>;
  open(options: { heartlandPublicKey: string}): Promise<{heartlandPublicKey: string}>;
}
