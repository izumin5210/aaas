/* @flow */
import { camelizeKeys, decamelizeKeys } from 'humps'

export function camel2snake (obj: Object) {
  return decamelizeKeys(obj, { split: /(?=[A-Z0-9])/ })
}

export function snake2camel (obj: Object) {
  return camelizeKeys(obj)
}
