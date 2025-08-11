import cs_bot
from cs_bot import StartupConfig
from cs_bot.adapters import sop_bot
from cs_bot.models import db, PluginConfig  # import DB and model
import os

config = {
    "adapter": {
        "app_id": "ODkxNDI2ODM2NjMw",
        "app_secret": "_lsE46-ag2WezJjNRpxf6YfSFvYLb5RM",
        "signing_secret": "d79AvCr5raiRvQEROLDEsxBXvHm2UrWw"
    },
    "database": {
        "url": "sqlite:///./data.db"  # use file-based sqlite db
    }
}

cs_bot.init(StartupConfig.parse_obj(config))

# Connect and create required tables **before** plugin loading
db.connect()
db.create_tables([PluginConfig])
db.close()

cs_bot.register_adapter(sop_bot.Adapter)
cs_bot.load_plugin("plugins.echo")

if __name__ == '__main__':
    cs_bot.run(host="0.0.0.0", port=int(os.environ.get("PORT", 8000)))
