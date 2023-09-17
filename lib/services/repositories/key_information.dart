const kPushNotificationBearerToken =
    'AAAAyE7tf9c:APA91bG5QL2wN5uyVD46nOxrQZw-dxBBb-hf0bDLlD3_a9PgJ51mv_fmdTVRulz2uj51EcKNxTTFBK3cWkmFjFFu6fUM4Hd1_O2USwIseshTW6E1ZMf_JT0oeiLaYZv2NqNW1lSjJML6';
//'AAAAxFqFtxU:APA91bEnNJXU4m4nV_Rsb5pDHSmei7TLxjp5jfPdkDTCNRs2wYhk2Bg7G5-kg9dUtuPOdi4dwLh0oBza03Jca0bjcHoQhWySlqtXx7TOFfjfse2BtQgbgGoOOQgpxBuap_cB_KotUNMc';

// https://fcm.googleapis.com/v1/projects/nic-besocial/messages:send

// https://fcm.googleapis.com/fcm/send [deprecated]

const kGooglePlaceSearchKey = 'AIzaSyCAHaJ_6QsR4Xs_EdWbcL6QEcbUr3S3nE0';






// const stripePublishableKey = 'pk_test_51Nnc7KSDpJF2TWQ4AgPHCagRFZtKXDqerm3JFyyBP4XC5j2xYm56X88fQjcQC3KxxVwlSV8qZ23Gjfj03sysi0Wt00I8z25M8l';
// const stripeSecretKey = 'sk_test_51Nnc7KSDpJF2TWQ4vXtkSyF9LmjItnqDSm5Bvkv5QMXiDW0rdKA21xa6m9yraEMtIbprDY6a00ySkjqz25EPhveE00CR5i03mr';



//-----------------------

  const _publishableKeyLive = 'pk_live_51Nqe3fSCVxfmEN4OWYR80koivx9CIwVOcONtCthuFSSWsoOZgL2nMQGSuVgk2kqPc4zSaCgMOJCUX4td4xnEN3Vy00QZfmB0nT';
  const _secretKeyLive = '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';

  const _publishableKeyTest = 'pk_test_51Nqe3fSCVxfmEN4OXe3S3YAZgnYGefoVXBxrvcs1zt1bWGvMmB6jPPOCp9Hnm3EWJQWPT58xxTibPDwDIHbMiRlL00w2gSAiHm';
  const _secretKeyTest = 'sk_test_51Nqe3fSCVxfmEN4Oh2IWxGo3GjN8spXLVooUf1RFKOVhcjEQvFqO8DusEGysp57KVxDXvSbQC7WXVDHVu5HGZoAG00MX0ZdlOj'; //NIC

class StripeKey{
  static String get secretKey => _secretKeyLive;
  static String get publishableKey => _publishableKeyLive;
}

