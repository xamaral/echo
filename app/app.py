import logging


from aiohttp import web


async def echo(request):
    return web.Response(
        text=await request.text()
    )

def setup_routes(app):
    app.router.add_routes([
        web.post('/', echo)
    ])

def make_app(log_level=logging.DEBUG):
    logging.basicConfig(level=log_level)
    app = web.Application()
    setup_routes(app)
    return app

def main():
    app = make_app()
    web.run_app(app)


if __name__ == '__main__':
    main()
