certificate_arn = "${{ secrets.CERTIFICATE_ARN }}"
private_key = "${{ secrets.EC2_PRIVATE_KEY }}"
access_key = "${{ secrets.AWS_ACCESS_KEY_ID }}"
secret_key = "${{ secrets.AWS_SECRET_ACCESS_KEY }}"




instance_type      = "${{ env.INSTANCE_TYPE }}"
private_key_name =    "${{ env.PRIVATE_KEY }}"
region = "${{ env.AWS_REGION }}"