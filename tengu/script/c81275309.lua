--氷結界の虎将 ライホウ
--General Raiho of the Ice Barrier
function c81275309.initial_effect(c)
	--When your opponent's monster effect activated on the field resolves, they must discard 1 card or the effect is negated
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c81275309.handes)
	c:RegisterEffect(e1)
end
s[0]=0
function c81275309.handes(e,tp,eg,ep,ev,re,r,rp)
	local trig_loc,chain_c81275309=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION,CHAININFO_CHAIN_ID)
	if not (ep==1-tp and trig_loc==LOCATION_MZONE and chain_c81275309~=s[0] and re:IsMonsterEffect()) then return end
	s[0]=chain_c81275309
	if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 and Duel.SelectYesNo(1-tp,aux.Stringc81275309(c81275309,0)) then
		Duel.DiscardHand(1-tp,nil,1,1,REASON_EFFECT|REASON_DISCARD,nil)
		Duel.BreakEffect()
	else Duel.NegateEffect(ev) end
end