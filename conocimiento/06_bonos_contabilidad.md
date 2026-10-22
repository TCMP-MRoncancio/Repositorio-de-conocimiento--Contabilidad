# Bonos: contabilidad

La clasificación de la cartera decide dónde va la valoración: Trading a resultados por precio sucio, HTM a resultados por TIR, y AFS a resultados por TIR con la diferencia de mercado en patrimonio. Compra, venta, cupones y amortizaciones usan los mismos eventos para las tres; cambia la revaluación y la reclasificación al vender. Los ejemplos del video 05 usan el deal 3108228 (COP, 16/06/2020) con cuentas genéricas por prefijo.

## 1. Compra (Trading / AFS / HTM)

Valor de compra = nominal + interés comprado ± premio/descuento.

| Evento | Cuenta | Descripción | Monto | D/C |
| --- | --- | --- | --- | --- |
| Position Data | 13XXXX | Alta en Balance – Compra Bond Deal | Valor de compra | Débito |
| Position Data | 25XXXX | Cuentas por Pagar | Valor de compra | Crédito |
| Payment | 25XXXX | Cuentas por Pagar | Valor de compra | Débito |
| Payment | 11XXXX | Cuenta Liquidación | Valor de compra | Crédito |
| Position Data | 81XXXX | Cuentas de Orden Inversiones | Valor de compra | Débito |
| Position Data | 83XXXX | Cuentas de Orden Inversiones | Valor de compra | Crédito |

## 2. Revaluación diaria (Position Revaluation, by deal)

| Cartera | Qué se registra | Contrapartida |
| --- | --- | --- |
| Trading | Variación MtM a precio sucio (13XXXX contra 51XXXX) | Cuenta de resultados |
| HTM | Valoración a TIR de compra (13XXXX contra 51XXXX) | Cuenta de resultados |
| AFS | Valoración a TIR a resultados (51XXXX) y, además, variación MtM precio sucio menos valoración a TIR | Patrimonio (38XXXX) |

En todos los casos se replica el movimiento en cuentas de orden (81XXXX / 83XXXX). El ejemplo de la diapositiva muestra una pérdida (balance a crédito, PyG a débito); con ganancia los signos se invierten.

## 3. Venta

| Evento | Cuenta | Descripción | Monto | D/C |
| --- | --- | --- | --- | --- |
| Position Data | 13XXXX | Baja en Balance | Valor en libros | Crédito |
| Position Data | 41XXXX | Utilidad/Pérdida Venta Inversiones | PL realizado | Crédito (si hay utilidad) |
| Payment | 25XXXX | Cuentas por Pagar (cobrar) | Valor de venta | Débito y crédito |
| Payment | 11XXXX | Cuenta Liquidación | Valor de venta | Débito |
| Position Data | 81XXXX / 83XXXX | Cuentas de Orden Inversiones | Valor en libros | Reverso |

Solo en **AFS**, además se reclasifica el saldo acumulado en patrimonio: 38XXXX a débito contra 41XXXX a crédito (Reclasificación Saldo Patrimonio). Así la ganancia o pérdida que estaba en ORI pasa a resultados al vender.

## 4. Pago de cupón y amortización (todas las carteras)

| Evento | Cuenta | Cupón | Amortización | D/C |
| --- | --- | --- | --- | --- |
| Corporate Action | 13XXXX | Baja Balance – Pago Cupón | Baja Balance – Amortización | Crédito |
| Corporate Action | 16XXXX | Cuentas por Pagar (cobrar) | Cuentas por Pagar (cobrar) | Débito |
| Payment | 16XXXX | Cuentas por Pagar (cobrar) | Cuentas por Pagar (cobrar) | Crédito |
| Payment | 11XXXX | Cuenta Liquidación | Cuenta Liquidación | Débito |

El monto es el valor del cupón pagado o del nominal amortizado. La amortización reduce el saldo vivo del bono; el cupón cancela el interés causado que estaba en el valor del título.
