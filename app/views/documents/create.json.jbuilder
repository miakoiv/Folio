json.partial! 'documents/document', document: @document
json.document_path document_path(@document, format: :js)
