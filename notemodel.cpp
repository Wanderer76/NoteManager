#include "notemodel.h"
#include<QHash>
#include<QByteArray>
#include<QSettings>
#include<QDebug>
NoteModel::NoteModel()
{
    QSettings settings("ARTYOMCOMP","NOTEMANAGER");

    /* beginInsertRows(QModelIndex(),0,2);
  _notes.append(new note("asdf",0,1));
  _notes.append(new note("AWD",1,0));
  endInsertRows();*/
}

NoteModel::~NoteModel()
{}

QVariant NoteModel::data(const QModelIndex &index, int role) const
{
    if(index.isValid()==false)
    {
        return {};
    }
    if(role == Role::TextRole)
        return QVariant::fromValue(_notes.at(index.row())->_noteText);
    if(role==Role::CheckRole)
        return QVariant::fromValue(_notes.at(index.row())->_isChecked);
    if(role==Role::AcecptRole)
        return QVariant::fromValue(_notes.at(index.row())->_isAccept);
    else
        return {};
}

int NoteModel::rowCount(const QModelIndex&parent) const
{
    return this->_notes.size();
}

QHash<int, QByteArray> NoteModel::roleNames() const
{
    QHash<int,QByteArray> roles;
    roles[Role::TextRole] = "note";
    roles[Role::CheckRole]="isChecked";
    roles[Role::AcecptRole] = "isAccepted";
    return roles;
}

void NoteModel::save()
{
    QSettings settings("ARTYOMCOMP","NOTEMANAGER");
    QStringList noteList,check,accept;

    for(auto i:_notes)
    {
        noteList<<i->_noteText;
        check <<QString::number(i->_isChecked);
        accept<<QString::number(i->_isAccept);
        qDebug()<<"Save: "<<noteList<<check<<accept;
    }
    settings.beginGroup("/Data");
    settings.setValue("/text",noteList);
    settings.setValue("/check",check);
    settings.setValue("/accept",accept);
    settings.endGroup();

    qDebug()<<"Save";
}

void NoteModel::load()
{
    QStringList noteList,check,accept;
    QSettings settings("ARTYOMCOMP","NOTEMANAGER");
    settings.beginGroup("/Data");
    noteList = settings.value("/text").toStringList();
    check = settings.value("/check").toStringList();
    accept = settings.value("/accept").toStringList();
    settings.endGroup();

    if(!noteList.isEmpty()){
        beginInsertRows(QModelIndex(),0,noteList.size()-1);
        for(int i=0;i<noteList.size();++i)
        {
            _notes.push_back(new note(noteList.at(i),check.at(i).toInt(),accept.at(i).toInt()));
            qDebug()<<_notes[i]->_noteText<<_notes[i]->_isChecked<<_notes[i]->_isAccept;
        }
        endInsertRows();
        qDebug()<<"load";
    }
}

void NoteModel::addItem()
{
    int index;
    if(rowCount()==0)
        index = 0;
    else
        index = rowCount();

    beginInsertRows(QModelIndex(),rowCount(),index);
    _notes.push_back(new note());
    endInsertRows();

    emit dataChanged(createIndex(0,0),createIndex(rowCount()-1 ,0));
}

void NoteModel::removeRow(const int index)
{    
    beginRemoveRows(QModelIndex(),index,index);
    _notes.removeAt(index);
    endRemoveRows();
   emit dataChanged(createIndex(0,0),createIndex(rowCount()-1,0));
}
