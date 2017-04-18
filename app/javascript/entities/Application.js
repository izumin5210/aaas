/* @flow */
import { Record } from 'immutable'

export type ApplicationConfig = {
  id: number,
  name: string,
  uid: string,
  secret: string,
  redirectUris: Array<string>,
  scopes: Array<string>,
}

const defaultValues: ApplicationConfig = {
  id: 0,
  name: '',
  uid: '',
  secret: '',
  redirectUris: [],
  scopes: []
}

const ApplicationRecord = Record(defaultValues)

// https://github.com/facebook/immutable-js/pull/1193
// $FlowFixMe
export default class Application extends ApplicationRecord {
}
