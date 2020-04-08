#pragma once
#include<QAbstractListModel>
#include<QModelIndex>

class NoteModel : public QAbstractListModel
{
    Q_OBJECT
private:

    enum Role{TextRole = Qt::UserRole+1,CheckRole,AcecptRole};

    struct note
    {
        QString _noteText;
        bool _isChecked;
        bool _isAccept;
        note(const QString&note,const bool& check,const bool& accept):_noteText(note),_isChecked(check),_isAccept(accept)  {}
        note():_noteText(""),_isChecked(false),_isAccept(false) {}
    };
    QVector<note*> _notes;
public:
    NoteModel();
    ~NoteModel();
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual int rowCount(const QModelIndex&parent = QModelIndex())const override;
    QHash<int,QByteArray>roleNames()const override;
    Q_INVOKABLE  void load();
    Q_INVOKABLE  void save();
    Q_INVOKABLE void addItem();
    Q_INVOKABLE void removeRow(const int index);


    Q_INVOKABLE void setStr(const int& index, const QString &str)
    {
        _notes.at(index)->_noteText = str;
    }

    Q_INVOKABLE void setChecked(const int& index, const bool &is)
    {
        _notes.at(index)->_isChecked = is;
    }

    Q_INVOKABLE void setAccepted(const int&index,const bool&is)
    {
        _notes.at(index)->_isAccept = is;
    }

    Q_INVOKABLE QString getStr(const int &index)const {return _notes.at(index)->_noteText;}
    Q_INVOKABLE bool getCheck(const int &index)const {return _notes.at(index)->_isChecked;}
    Q_INVOKABLE bool getAccept(const int &index)const {return _notes.at(index)->_isAccept;}
};

