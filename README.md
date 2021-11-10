# Aca-py and tails server images

This repo provides sources for the aca-py and tails server images, providing a basic docker image of both. These images use a base installation of aca-py and tails server and add changes necessary for running with a random user, like when running in security-focussed Kubernetes distributions such as openshift.

Please refer to the official DOcumentaion of [indy tails server](https://github.com/bcgov/indy-tails-server) and [Aca-Py](https://github.com/hyperledger/aries-cloudagent-python).

## Aca-py image env vars 

### Admin

| Env var | Description | Default |
|---|---|---|
| ACAPY_ADMIN_API_KEY       | Protect all admin endpoints with the provided API key. API clients (e.g. the controller) must pass the key in the HTTP header using 'X-API-Key: <api key>'. Either this parameter or the '--admin-insecure-mode' parameter MUST be specified.                                                  |
| ACAPY_ADMIN_INSECURE_MODE | Run the admin web server in insecure mode. DO NOT USE FOR PRODUCTION DEPLOYMENTS. The admin server will be publicly available to anyone who has access to the interface. Either this parameter or the '--api-key' parameter MUST be specified.                                                 |
| ACAPY_NO_RECEIVE_INVITES  | Prevents an agent from receiving invites by removing the '/connections/receive-invite' route from the administrative interface.                                                                                                                                                                | false.                          |
| ACAPY_HELP_LINK           | A URL to an administrative interface help web page that a controller user interface can get from the agent and provide as a link to users.                                                                                                                                                     |
| ACAPY_WEBHOOK_URL         | Send webhooks containing internal state changes to the specified URL. Optional API key to be passed in the request body can be appended using a hash separator [#]. This is useful for a controller to monitor agent events and respond to those events using the admin API. If not specified, | webhooks are not published by the agent. |

### Debug
| Env var | Description | Default |
|---|---|---|
| ACAPY_DEBUG | Enables a remote debugging service that can be accessed using ptvsd for Visual Studio Code. The framework will wait for the debugger to connect at start-up. | false. |
| ACAPY_DEBUG_SEED | Specify the debug seed to use. |
| ACAPY_DEBUG_CONNECTIONS | Enable additional logging around connections. | false. |
| ACAPY_DEBUG_CREDENTIALS | Enable additional logging around credential exchanges. | false. |
| ACAPY_DEBUG_PRESENTATIONS | Enable additional logging around presentation exchanges. | false. |
| ACAPY_INVITE | After startup, generate and print a new out-of-band connection invitation URL. | false. |
| ACAPY_CONNECTIONS_INVITE | After startup, generate and print a new connections protocol style invitation URL. | false. |
| ACAPY_INVITE_LABEL | Specify the label of the generated invitation. |
| ACAPY_INVITE_MULTI_USE | Flag specifying the generated invite should be multi- use. |
| ACAPY_INVITE_PUBLIC | Flag specifying the generated invite should be public. |
| ACAPY_INVITE_METADATA_JSON | Add metadata json to invitation created with ACAPY_INVITE argument. |
| ACAPY_TEST_SUITE_ENDPOINT | URL endpoint for sending messages to the test suite agent. |
| ACAPY_AUTO_ACCEPT_INVITES | Automatically accept invites without firing a webhook event or waiting for an admin request. | false. |
| ACAPY_AUTO_ACCEPT_REQUESTS | Automatically accept connection requests without firing a webhook event or waiting for an admin request. | false. |
| ACAPY_AUTO_RESPOND_MESSAGES | Automatically respond to basic messages indicating the message was received. | false. |
| ACAPY_AUTO_RESPOND_CREDENTIAL_PROPOSAL | Auto-respond to credential proposals with corresponding credential offers |
| ACAPY_AUTO_RESPOND_CREDENTIAL_OFFER | Automatically respond to Indy credential offers with a credential request. | false |
| ACAPY_AUTO_RESPOND_CREDENTIAL_REQUEST | Auto-respond to credential requests with corresponding credentials |
| ACAPY_AUTO_RESPOND_PRESENTATION_PROPOSAL | Auto-respond to presentation proposals with corresponding presentation requests |
| ACAPY_AUTO_RESPOND_PRESENTATION_REQUEST | Automatically respond to Indy presentation requests with a constructed presentation if a corresponding credential can be retrieved for every referent in the presentation request. | false. |
| ACAPY_AUTO_STORE_CREDENTIAL | Automatically store an issued credential upon receipt. | false. |
| ACAPY_AUTO_VERIFY_PRESENTATION | Automatically verify a presentation when it is received. | false. |

### General
| Env var | Description | Default |
|---|---|---|
| ARG*FILE Load aca-py arguments from the specified file. Note that this file \_must* be in YAML format.|
| ACAPY_PLUGIN | as external plugin module. Multiple instances of this parameter can be specified. |
| ACAPY_STORAGE_TYPE | Specifies the type of storage provider to use for the internal storage engine. This storage interface is used to store internal state. Supported internal storage types are 'basic' (memory) and 'indy'. The default (if not specified) is 'indy' if the wallet type is set to 'indy', otherwise 'basic' |
| ACAPY_ENDPOINT | Specifies the endpoints to put into DIDDocs to inform other agents of where they should send messages destined for this agent. Each endpoint could be one of the specified inbound transports for this agent, or the endpoint could be that of another |agent (e.g. 'https://example.com/agent-endpoint') if the routing of messages to this agent by a mediator is configured. The first endpoint specified will be used in invitations. The endpoints are used in the formation of a connection with another agent. |
| ACAPY_PROFILE_ENDPOINT | Specifies the profile endpoint for the (public) DID. |
| ACAPY_READ_ONLY_LEDGER | Sets ledger to read-only to prevent updates. | false. |
| ACAPY_TAILS_SERVER_BASE_URL | Sets the base url of the tails server in use. |
| ACAPY_TAILS_SERVER_UPLOAD_URL | Sets the base url of the tails server for upload, | defaulting to the tails server base url. |

### Ledger
| Env var | Description | Default |
|---|---|---|
| ACAPY_LEDGER_POOL_NAME | Specifies the name of the indy pool to be opened. This is useful if you have multiple pool configurations. |
| ACAPY_GENESIS_TRANSACTIONS | Specifies the genesis transactions to use to connect to an Hyperledger Indy ledger. The transactions are provided as string of JSON e.g. '{"reqSignature":{},"txn":{"data":{"d... <snip>' |
| ACAPY_GENESIS_FILE | Specifies a local file from which to read the genesis transactions. |
| ACAPY_GENESIS_URL | Specifies the url from which to download the genesis transactions. For example, if you are using 'von- network', the URL might be 'http://localhost:9000/genesis'. Genesis transactions URLs are available for the Sovrin test/main networks. |
| ACAPY_NO_LEDGER | Specifies that aca-py will run with no ledger configured. This must be set if running in no-ledger mode. Overrides any specified ledger or genesis configurations. | false. |

### Logging
| Env var | Description | Default |
|---|---|---|
| ACAPY_LOG_CONFIG | Specifies a custom logging configuration file |
| ACAPY_LOG_FILE | Overrides the output destination for the root logger (as defined by the log config file) to the named <log- file>. |
| ACAPY_LOG_LEVEL | Specifies a custom logging level as one of: ('debug', 'info', 'warning', 'error', 'critical') |

### Protocol
| Env var | Description | Default |
|---|---|---|
| ACAPY_AUTO_PING_CONNECTION | Automatically send a trust ping immediately after a connection response is accepted. Some agents require this before marking a connection as 'active'. | false |
| ACAPY_INVITE_BASE_URL | Base URL to use when formatting connection invitations in URL format. |
| ACAPY_MONITOR_PING | Send a webhook when a ping is sent or received. |
| ACAPY_PUBLIC_INVITES | Send invitations out, and receive connection requests, using the public DID for the agent. | false |
| ACAPY_TIMING | Include timing information in response messages. |
| ACAPY_TIMING_LOG | Write timing information to a given log file. |
| Generate tracing events. | [env var: ACAPY_TRACE]
| ACAPY_TRACE_TARGET | Target for trace events ("log", "message", or http endpoint). |
| ACAPY_TRACE_TAG | Tag to be included when logging events. |
| ACAPY_TRACE_LABEL | Label (agent name) used logging events. |
| ACAPY_PRESERVE_EXCHANGE_RECORDS | Keep credential exchange records after exchange has completed. |
| ACAPY_EMIT_NEW_DIDCOMM_PREFIX | Emit protocol messages with new DIDComm prefix; i.e., 'https://didcomm.org/' instead of ( default) prefix 'did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/'. |
| ACAPY_EMIT_NEW_DIDCOMM_MIME_TYPE | Send packed agent messages with the DIDComm MIME type as of RFC 0044; i.e., 'application/didcomm-envelope- enc' instead of 'application/ssi-agent-wire'. |
| ACAPY_EXCH_USE_UNENCRYPTED_TAGS | Store tags for exchange protocols (credential and presentation) using unencrypted rather than encrypted tags |

### Start-up
| Env var | Description | Default |
|---|---|---|
| ACAPY_AUTO_PROVISION | If the requested profile does not exist, initialize it with the given parameters. |

### Transport
| Env var | Description | Default |
|---|---|---|
| ACAPY_INBOUND_TRANSPORT Defines the inbound transport(s) on which the agent listens for receiving messages from other agents. This parameter can be specified multiple times to create multiple interfaces. Built-in inbound transport types include 'http' and 'ws'. However, other transports can be loaded by specifying an absolute module path.| http 0.0.0.0 11000 |
| ACAPY_OUTBOUND_TRANSPORT | Defines the outbound transport(s) on which the agent will send outgoing messages to other agents. This parameter can be passed multiple times to supoort multiple transport types. Supported outbound transport types are 'http' and 'ws'. | http |
| ACAPY_LABEL-l <label>, --label <label> Specifies the label for this agent. This label is publicized (self-attested) to other agents as part of forming a connection. |
| ACAPY_IMAGE_URL | IMAGE_URL Specifies the image url for this agent. This image url is publicized (self-attested) to other agents as part of forming a connection. |
| ACAPY_MAX_MESSAGE_SIZE | Set the maximum size in bytes for inbound agent messages. |
| ACAPY_ENABLE_UNDELIVERED_QUEUE | Enable the outbound undelivered queue that enables this agent to hold messages for delivery to agents without an endpoint. This option will require additional memory to store messages in the queue. |
| ACAPY_MAX_OUTBOUND_RETRY | MAX_OUTBOUND_RETRY Set the maximum retry number for undelivered outbound messages. Increasing this number might cause to increase the accumulated messages in message queue. | 4 |

### Mediation
| Env var | Description | Default |
|---|---|---|
| Enables didcomm mediation. After establishing a connection, if enabled, an agent may request message mediation, which will allow the mediator to forward messages on behalf of the recipient. See aries- rfc:0211.|
| ACAPY_MEDIATION_INVITATION | Connect to mediator through provided invitation and send mediation request and set as default mediator. |
| ACAPY_MEDIATION_CONNECTIONS_INVITE | Connect to mediator through a connection invitation. If not specified, connect using an OOB invitation. | false. |
| ACAPY_DEFAULT_MEDIATION_ID | default-mediator-id <mediation id> Set the default mediator by ID |
| ACAPY_CLEAR_DEFAULT_MEDIATOR | default-mediator Clear the stored default mediator. |

### Wallet
| Env var | Description | Default |
|---|---|---|
| ACAPY_WALLET_SEED | Specifies the seed to use for the creation of a public DID for the agent to use with a Hyperledger Indy ledger, or a local (ACAPY_WALLET_LOCAL_DID) DID. If public, the DID must already exist on the ledger. |
| ACAPY_WALLET_LOCAL_DID | If this parameter is set, provisions the wallet with a local DID from the ACAPY_WALLET_SEED parameter, instead of a public DID to use with a Hyperledger Indy ledger. |
| ACAPY_WALLET_KEY | Specifies the master key value to use to open the wallet. |
| ACAPY_WALLET_REKEY | Specifies a new master key value to which to rotate and to open the wallet next time. |
| ACAPY_WALLET_NAME | Specifies the wallet name to be used by the agent. This is useful if your deployment has multiple wallets. |
| ACAPY_WALLET_TYPE | Specifies the type of Indy wallet provider to use. Supported internal storage types are 'basic' (memory) and 'indy' | 'basic'. |
| ACAPY_WALLET_STORAGE_TYPE | Specifies the type of Indy wallet backend to use. Supported internal storage types are 'basic' (memory), 'default' (sqlite), and 'postgres_storage'. | 'default'. |
| ACAPY_WALLET_STORAGE_CONFIG | Specifies the storage configuration to use for the wallet. This is required if you are for using 'postgres_storage' wallet storage type. For example, '{"url":"localhost:5432", "wallet_scheme":"MultiWalletSingleTable"}'. This configuration maps to the indy sdk postgres plugin |(PostgresConfig). |
| ACAPY_WALLET_STORAGE_CREDS | Specifies the storage credentials to use for the wallet. This is required if you are for using 'postgres_storage' wallet For example, '{"account":"postgres","password": "mysecretpassword","admin_account":"postgres", "admin_password":"mysecretpassword"}'. This configuration maps |to the indy sdk postgres plugin (PostgresCredentials). NOTE: admin_user must have the CREATEDB role or else initialization will fail. |
| ACAPY_REPLACE_PUBLIC_DID | If this parameter is set and an agent already has a public DID, and the ACAPY_WALLET_SEED parameter specifies a new DID, the agent will use the new DID in place of the existing DID. | false. |
| ACAPY_RECREATE_WALLET | If an existing wallet exists with the same name, remove and recreate it during provisioning. |

### Multitenant
| Env var | Description | Default |
|---|---|---|
| ACAPY_MULTITENANT | Enable multitenant mode. |
| ACAPY_MULTITENANT_JWT_SECRET | Specify the secret to be used for Json Web Token (JWT) creation and verification. The JWTs are used to authenticate and authorize multitenant wallets. |
| ACAPY_MULTITENANT_ADMIN | Specify whether to enable the multitenant admin api. |

## Tails Server env vars

| Env var | Description | Default |
|---|---|---|
| TAILS_SERVER_ADDRESS | External address of the tails server |
| TAILS_SERVER_LOG_LEVEL | Log level |
