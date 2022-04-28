import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class JazzCashHelper {
  payment() async {
    String dateandtime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
    String dexpiredate = DateFormat("yyyyMMddHHmmss")
        .format(DateTime.now().add(const Duration(days: 1)));
    String tre = "T" + dateandtime;
    String ppAmount = "100";
    String ppBankID = "";
    String ppBillReference = "billRef";
    String ppDescription = "Description";
    String ppLanguage = "EN";
    String ppMerchantID = "MC39346";
    String ppPassword = "v6d6uwa8w1";
    String ppReturnURL =
        "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
    String ppVer = "1.1";
    String ppTxnCurrency = "PKR";
    String ppTxnDateTime = dateandtime.toString();
    String ppTxnExpiryDateTime = dexpiredate.toString();
    String ppTxnRefNo = tre.toString();
    String ppTxnType = "MWALLET";
    String ppmpf_1 = "03045930586";
    String integeritySalt = "xd8vtv9t9z";
    String and = '&';
    String superdata = integeritySalt +
        and +
        ppAmount +
        and +
        ppBillReference +
        and +
        ppDescription +
        and +
        ppLanguage +
        and +
        ppMerchantID +
        and +
        ppPassword +
        and +
        ppReturnURL +
        and +
        ppTxnCurrency +
        and +
        ppTxnDateTime +
        and +
        ppTxnExpiryDateTime +
        and +
        ppTxnRefNo +
        and +
        ppTxnType +
        and +
        ppVer +
        and +
        ppmpf_1;

    var key = utf8.encode(integeritySalt);
    var bytes = utf8.encode(superdata);
    var hmacSha256 = Hmac(sha256, key);
    Digest sha256Result = hmacSha256.convert(bytes);
    var url =
        'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';

    var response = await Dio().post(url, data: {
      "pp_Version": ppVer,
      "pp_TxnType": ppTxnType,
      "pp_Language": ppLanguage,
      "pp_MerchantID": ppMerchantID,
      "pp_Password": ppPassword,
      "pp_BankID": ppBankID,
      "pp_TxnRefNo": tre,
      "pp_Amount": ppAmount,
      "pp_TxnCurrency": ppTxnCurrency,
      "pp_TxnDateTime": dateandtime,
      "pp_BillReference": ppBillReference,
      "pp_Description": ppDescription,
      "pp_TxnExpiryDateTime": dexpiredate,
      "pp_ReturnURL": ppReturnURL,
      "pp_SecureHash": sha256Result.toString(),
      "ppmpf_1": ppmpf_1,
    });

    if (kDebugMode) {
      print("response=>");
      print(response.data);
    }
  }
}
