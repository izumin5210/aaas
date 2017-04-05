/* @flow */
import { Record } from 'immutable'

type ApplicationConfig = {
  name: string,
  uid: string,
  secret: string,
  redirectUris: Array<string>,
  scopes: Array<string>,
}

const defaultValues: ApplicationConfig = {
  name: '',
  uid: '',
  secret: '',
  redirectUris: [],
  scopes: [],
}

const ApplicationRecord = Record(defaultValues)

export default class Application extends ApplicationRecord {
}
