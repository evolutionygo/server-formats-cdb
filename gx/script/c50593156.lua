--サンド・ギャンブラー
--Sand Gambler
function c50593156.initial_effect(c)
	--Toss 3 coins and destroy monsters on the field
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc50593156(c50593156,0))
	e1:SetCategory(CATEGORY_COIN+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c50593156.destg)
	e1:SetOperation(c50593156.desop)
	c:RegisterEffect(e1)
end
c50593156.toss_coin=true
function c50593156.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,3)
end
function c50593156.desop(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2,c3=Duel.TossCoin(tp,3)
	if Duel.CountHeads(c1,c2,c3)==3 then
		local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(g,REASON_EFFECT)
	elseif Duel.CountTails(c1,c2,c3)==3 then
		local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,0,nil)
		Duel.Destroy(g,REASON_EFFECT)
	end
end