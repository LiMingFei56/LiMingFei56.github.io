## python3 生成uuid 和 token
source: `{{ page.path }}`

### uuid

import uuid
uuid.uuid1()
uuid.uuid3(namespace, len)
uuid.uuid4()
uuid.uuid5(namespace, len)

### random
import random
import string
print(''.join(random.sample(string.ascii_letters + string.digits + string.ascii_uppercase + string.digits, 64)))


## Reference

