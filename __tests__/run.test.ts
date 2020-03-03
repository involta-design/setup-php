import * as semver from 'semver';
import * as installer from '../src/installer';

describe('example tests', () => {
  it('testing', () => {
    expect(true).toBe(true);
  });
  it('hasPatchVersion tests', () => {
    expect(installer.hasPatchVersion('5')).toBe(false);
    expect(installer.hasPatchVersion('5.5')).toBe(false);
    expect(installer.hasPatchVersion('5.5.5')).toBe(true);
  });
  it('hasAptVersion tests', () => {
    expect(installer.hasAptVersion('5')).toBe(false);
    expect(installer.hasAptVersion('5.5')).toBe(false);
    expect(installer.hasAptVersion('5.5.5')).toBe(false);
    expect(installer.hasAptVersion('5.6.40')).toBe(false);
    expect(installer.hasAptVersion('5.6')).toBe(true);
    expect(installer.hasAptVersion('5.7')).toBe(false);
    expect(installer.hasAptVersion('7.0')).toBe(true);
    expect(installer.hasAptVersion('7.1')).toBe(true);
    expect(installer.hasAptVersion('7.2')).toBe(true);
    expect(installer.hasAptVersion('7.3')).toBe(true);
    expect(installer.hasAptVersion('7.4')).toBe(true);
  });
  it('convertInstallVersion tests', () => {
    expect(installer.convertInstallVersion('5')).toBe('5');
    expect(installer.convertInstallVersion('5.4')).toBe('5.4.45');
    expect(installer.convertInstallVersion('5.5')).toBe('5.5.38');
    expect(installer.convertInstallVersion('5.6')).toBe('5.6.40');
    expect(installer.convertInstallVersion('7')).toBe('7');
    expect(installer.convertInstallVersion('7.1')).toBe('7.1.33');
    expect(installer.convertInstallVersion('7.2')).toBe('7.2.25');
    expect(installer.convertInstallVersion('7.3')).toBe('7.3.12');
    expect(installer.convertInstallVersion('7.4')).toBe('7.4.0');
    expect(installer.convertInstallVersion('7.3.8')).toBe('7.3.8');
  });
});
