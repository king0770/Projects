#!/usr/bin/ruby

#Description: Simple ruby script to query zimbra-ldap nodes for all active accounts
#See, https://wiki.zimbra.com/wiki/King0770-Notes-ldapsearch-to-csv

require 'net/ldap'

ldap = Net::LDAP.new  :host => "zimbra-ldap.example.com",
                      :port => "389",
                      :base => "ou=people,DC=example,DC=com", 
                      :auth => {
                      :method => :simple,
                      :username => "uid=zimbra,cn=admins,cn=zimbra",
                      :password => "s0Mep@sSw0rD"
                      }

filter = Net::LDAP::Filter.construct("(&(zimbraAccountStatus=active)(&(!(zimbraIsSystemResource=TRUE))(!(zimbraIsSystemAccount=TRUE))))")

treebase = "ou=people,dc=example,dc=com"

ldap.search(:base => treebase, :filter => filter) do |entry| 
		print "#{entry.displayName} " 
		print "#{entry.mail} " 
		print "#{entry.zimbraAccountStatus} " 
		puts
end