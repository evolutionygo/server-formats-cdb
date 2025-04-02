--サイレント・ウォビー (Anime)
--Silent Wobby (Anime)
function c511002771.initial_effect(c)
	--Change 1 monster your opponent controls to Defense Position and take control of it
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002771(c511002771,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511002771.posctrltg)
	e1:SetOperation(c511002771.posctrlop)
	c:RegisterEffect(e1)
end
function c511002771.posctrlfilter(c)
	return not c:IsPosition(POS_FACEUP_DEFENSE) and c:IsCanChangePosition() and c:IsControlerCanBeChanged()
end
function c511002771.posctrltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002771.posctrlfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511002771.posctrlfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511002771.posctrlop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectMatchingCard(tp,c511002771.posctrlfilter,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		if Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)>0 then
			Duel.GetControl(tc,tp)
		end
	end
end