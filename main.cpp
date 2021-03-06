#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include"notemodel.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    /*app.setOrganizationName("ArtyomCompany");
        app.setOrganizationDomain("temacompany.com");
        app.setApplicationName("NoteManager");*/

    const NoteModel model;

    qmlRegisterType<NoteModel>("NoteModel",1,0,"NoteModel");


    engine.load(url);

    return app.exec();
}
