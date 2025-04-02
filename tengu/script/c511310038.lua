--メールの階段
--Stairs of Mail
--Anime version scripted by AlphaKretin
function c511310038.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Change position
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511310038(c511310038,0))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511310038.postg)
	e2:SetOperation(c511310038.posop)
	c:RegisterEffect(e2)
	--register names
	aux.GlobalCheck(s,function()
		c511310038.name_list={}
		c511310038.name_list[0]={}
		c511310038.name_list[1]={}
		aux.AddValuesReset(function()
			c511310038.name_list[0]={}
			c511310038.name_list[1]={}
		end)
	end)
end
c511310038.listed_series={0x10b}
function c511310038.cfilter(c,tp)
	return c:IsSetCard(0x10b) and c:IsDiscardable(REASON_EFFECT) and not c511310038.name_list[tp][c:GetCode()]
end
function c511310038.posfilter(c)
	return c:IsCanChangePosition() and (c:IsPosition(POS_FACEUP_ATTACK) or c:IsPosition(POS_FACEDOWN_DEFENSE))
end
function c511310038.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511310038.cfilter,tp,LOCATION_HAND,0,1,nil,tp) and 
		Duel.IsExistingMatchingCard(c511310038.posfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,0,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,nil,1,0,0)
end
function c511310038.posop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local dc=Duel.SelectMatchingCard(tp,c511310038.cfilter,tp,LOCATION_HAND,0,1,1,nil,tp):GetFirst()
	if not dc or Duel.SendtoGrave(dc,REASON_DISCARD+REASON_EFFECT)==0 then return end
	c511310038.name_list[tp][dc:GetCode()]=true
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectMatchingCard(tp,c511310038.posfilter,tp,LOCATION_MZONE,0,1,1,nil)
	if #g>0 then
		Duel.BreakEffect()
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE,0,0,POS_FACEUP_ATTACK)
	end
end