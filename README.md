# Bank Slip Management

Management of bank slips with integration with external services


## Start app
Start full application

```bash
make start
```

Access: http://localhost:8080/

## Update environment
Necessary to update gateway token
- [Kobana](https://developers.kobana.com.br/reference/token-de-acesso)

After changing, restart the containers app to update the values

```bash
docker restart bank_slip_app
```
