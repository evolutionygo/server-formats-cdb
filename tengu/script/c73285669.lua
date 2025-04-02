--剣闘獣エセダリ
function c73285669.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2N(c,true,true,aux.FilterBoolFunctionEx(Card.IsSetCard,0x19),2)
	Fusion.AddContactProc(c,c73285669.contactfil,c73285669.contactop,c73285669.splimit)
end
c73285669.listed_series={0x19}
c73285669.material_setcode=0x19
function c73285669.contactfil(tp)
	return Duel.GetMatchingGroup(function(c) return c:IsMonster() and c:IsAbleToDeckOrExtraAsCost() end,tp,LOCATION_ONFIELD,0,nil)
end
function c73285669.contactop(g,tp)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_COST+REASON_MATERIAL)
end
function c73285669.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end