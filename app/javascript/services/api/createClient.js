/* @flow */
import axios from 'axios'
import type {
  Axios,
  AxiosXHRConfigBase,
  $AxiosXHR,
  $AxiosError
} from 'axios'

import {
  camel2snake,
  snake2camel
} from '../../utils/objects'

type ApiErrorResponse = {
  statusCode: number,
  error: string,
}

export type ApiResponse<T> = Promise<{
  response?: $AxiosXHR<T>,
  error?: $AxiosError<ApiErrorResponse>,
}>

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
  // $FlowFixMe
  if (error.response && error.response.data instanceof Object) {
    // $FlowFixMe
    error.response.data = snake2camel(error.response.data)
  }
  return { error }
}

export default function createClient (config?: AxiosXHRConfigBase<any>): Axios {
  const client = axios.create(config)
  client.interceptors.request.use(requestInterceptor)
  client.interceptors.response.use(successResponseInterceptor, errorResponseInterceptor)
  return client
}
