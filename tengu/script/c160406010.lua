--古代の遠眼鏡
--Ancient Telescope (Rush)
function c160406010.initial_effect(c)
	--confirm
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c160406010.cftg)
	e1:SetOperation(c160406010.cfop)
	c:RegisterEffect(e1)
end
function c160406010.cftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>4 end
	Duel.SetTargetPlayer(tp)
end
function c160406010.cfop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.ConfirmDecktop(1-tp,5)
end