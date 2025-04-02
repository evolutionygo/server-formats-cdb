--磨破羅魏
--Maharaghi
function c40695128.initial_effect(c)
	Spirit.AddProcedure(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--Cannot be Special Summoned
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--Look at top card next Draw Phase
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc40695128(c40695128,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetOperation(c40695128.regop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_FLIP)
	c:RegisterEffect(e3)
end
function c40695128.regop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,c40695128)~=0 then return end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCondition(c40695128.condition)
	e1:SetOperation(c40695128.operation)
	e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,1)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,c40695128,RESET_PHASE+PHASE_END,0,2)
	aux.RegisterClientHint(c,0,tp,1,0,aux.Stringc40695128(c40695128,1),RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,1)
end
function c40695128.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsTurnPlayer(tp) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
end
function c40695128.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,1)
	if #g==0 then return end
	Duel.ConfirmCards(tp,g)
	local opt=Duel.SelectOption(tp,aux.Stringc40695128(c40695128,2),aux.Stringc40695128(c40695128,3))
	if opt==1 then
		Duel.MoveSequence(g:GetFirst(),1)
	end
end