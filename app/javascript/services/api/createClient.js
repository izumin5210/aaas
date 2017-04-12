/* @flow */
import axios from 'axios'

import type { Axios, AxiosXHRConfigBase } from 'axios'

import {
  camel2snake,
  snake2camel,
} from '../../utils/objects'

const requestInterceptor = (config) => {
  if (config.data instanceof Object) {
    config.data = camel2snake(config.data)
  }
  if (config.params instanceof Object) {
    config.params = camel2snake(config.params)
  }
  return config
}

const successResponseInterceptor = (response) => {
  if (response.data instanceof Object) {
    response.data = snake2camel(response.data)
  }
  return { response }
}

const errorResponseInterceptor = (error) => {
  if (error.response && error.response.data instanceof Object) {
    error.response.data = snake2camel(error.response.data)
  }
  return { error }
}

export default function createClient(config?: AxiosXHRConfigBase<any>): Axios {
  const client = axios.create(config)
  client.interceptors.request.use(requestInterceptor)
  client.interceptors.response.use(successResponseInterceptor, errorResponseInterceptor)
  return client
}

