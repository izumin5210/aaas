/* @flow */
import createClient from './createClient'
import type { ApiResponse } from './createClient'

import type { ApplicationConfig } from '../../entities/Application'

const client = createClient()

const createTokenHeader = (token: string) => ({
  Accept: 'application/json',
  Authorization: `Bearer ${token}`
})

export function getApps (
  token: string
): ApiResponse<Array<ApplicationConfig>> {
  const headers = createTokenHeader(token)
  return client.get('/api/applications', { headers })
}
